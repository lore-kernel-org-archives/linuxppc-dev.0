Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 17 May 2003 13:18:24 +0800
Message-ID: <20030517131824.39906.qmail@eyou.com>
From: "rick.liu" <dovi@eyou.com>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: "rick.liu" <dovi@eyou.com>
Subject: kermit:How  to  disable the flow control signals?
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I installed c-kermit209 in my linux,and copy the dot.kermrc
in the u-boot0.3.0 to ~/.kermrc,then connect the kermit to my direct
-serral port:

bash>wermit -c
Connecting to /dev/ttyS0, speed 115200
 Escape character: Ctrl-\ (ASCII 28, FS): enabled
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
(and then ctrl_\ s)
Device: /dev/ttyS0
Speed 115200
 Terminal echo: remote
 Terminal bytesize: 8
 Command bytesize: 8
 Parity: none
 Autodownload: on
 Session log: (none)
 Carrier Detect      (CD):  On
 Dataset Ready       (DSR): On
 Clear To Send       (CTS): On
 Ring Indicator      (RI):  Off
 Data Terminal Ready (DTR): On
 Request To Send     (RTS): On

here is the question:
1.why the flow control signals are still "on"?
2.if I have a 3-wired smc1/serial port,how to configure
  to turn off RTS/CTS etc.?

Best regards
Thanks !!

Rick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
