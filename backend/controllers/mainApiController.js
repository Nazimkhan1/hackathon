
const express = require('express');

async function getData()
{
    console.log('GET API CONSUME HERE'); return false;
}

async function postData()
{
    console.log('POST API CONSUME HERE'); return false;
}

module.exports = { getData, postData }
