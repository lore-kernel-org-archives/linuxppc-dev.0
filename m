Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "=?big5?B?S2lyayBMZWU=?=" <mpc@mail2000.com.tw>
Reply-To: mpc@mail2000.com.tw
Subject: =?big5?B?RGVidWcgcHBjbGludXggd2l0aCBCREkyMDAw?=
Message-ID: <989520948.8638.mpc@mail2000.com.tw>
To: "=?big5?B?bGludXhwcGMtZW1iZWRkZWQ=?=" <linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 11 May 2001 02:55:48 +0800 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All:

 I am trying to debug ppclinux running on TQM8xxL
 with BDI2000.

 I followed the procedure mentioned in BDI's manual
 (Sec3.3.4, P29).
 I just type 'load' on BDI's telnet terminal to load
 target zImage file(arch/ppc/mbxboot/zImage).
 After that BDI shows:
 "File offset 0x00010000 to address 0x00210000 size
  514200"
 Then I type "go 0x00210000" on BDI's telnet terminal.
 However, nothing happened!!
 I can not get any responce from serial console.
 Did I lose something?

 Thanks

 kirk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
