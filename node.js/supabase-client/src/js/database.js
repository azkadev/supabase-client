var { createClient } = require("@supabase/supabase-js");
class Database {
    
    constructor(id, key) {
        this.client = createClient(`https://${id}.supabase.co`, key);
    }
    
    async add(from, datas) {
        const { data, error } = await this.client.from(from).insert(datas);
        if (error) {
            throw error;
        }
        return data;
    }
    
    async delete(from, datas) {
        const { data, error } = await this.client.from(from).delete().match(datas);
        if (error) {
            throw error;
        }
        return data;
    }
    async get(from, dataId, searchData, patern = "") {
        const { data, error } = await this.client.from(from).select();
        if (error) {
            throw error;
        }
        for (var index = 0; index < data.length; index++) {
            var loopData = data[index];
            if (RegExp(searchData, patern??"i").exec(loopData[String(dataId)])){
                return loopData;
            }
        }
        return null;
    }
    async getAll(from) {
        const { data, error } = await this.client.from(from).select();
        if (error) {
            throw error;
        }
        return data;
    }
    
    async insert(from, datas) {
        const { data, error } = await this.client.from(from).insert(datas);
        if (error) {
            throw error;
        }
        return data;
    }
    
    async updsert(from, datas) {
        const { data, error } = await this.client.from(from).insert(datas);
        if (error) {
            throw error;
        }
        return data;
    }

    async update(from, dataOrigin, dataUpdate) {
        const { data, error } = await this.client.from(from).update(dataUpdate).match(dataOrigin);
        if (error) {
            throw error;
        }
        return data;
    }
}

module.exports = {
    Database
};