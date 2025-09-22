package com.rajalakshmi.userservice;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

@Tag("String")
public class StringTest {

    @Test
    void testStringLength(){
        assertEquals(5,"Hello".length());
    }
}
