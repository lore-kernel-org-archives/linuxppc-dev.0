Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 17 May 2003 18:45:49 +0800
Message-ID: <20030517184549.35030.qmail@eyou.com>
From: "rick.liu" <dovi@eyou.com>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: "rick.liu" <dovi@eyou.com>
Subject: Re: kermit:How to disable the flow control signals?
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

thank you for ur reply,in your message,
======= 2003-05-17 09:29:00 you wrote:=======

>> 1.why the flow control signals are still "on"?
>
>Because this is what you serial  driver  reports  about  the  current
>state of these pins?

i donnot think so,for example,my NO.7 pin(RTS) and NO.9 pin(RI) both connect
to nothing,if your conclusion is correct,RTS and RI should be the same
state.But we
saw they are not the same.

>To verify, type "show comm" at the kermit prompt:

here is my info:

kermit>show comm

Communications Parameters:
 Line: /dev/ttyS0, speed: 115200, mode: local, modem: none
 Parity: none, stop-bits: (default) (8N1)
 Duplex: full, flow: none, handshake: none
 Carrier-watch: off, close-on-disconnect: off
 Lockfile: /var/lock/LCK..ttyS0
 Terminal bytesize: 8, escape character: 28 (^\)

 Carrier Detect      (CD):  On
 Dataset Ready       (DSR): On
 Clear To Send       (CTS): On
 Ring Indicator      (RI):  Off
 Data Terminal Ready (DTR): On
 Request To Send     (RTS): On

Type SHOW DIAL to see DIAL-related items.
Type SHOW MODEM to see modem-related items.

Now we can still see the RTS/CTS/DSR/CD/DTR are still on,why?

it my kermit version's problem?

Best regards,

Rick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
