Message-Id: <200004122245.AAA08151@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 Apr 2000 00:18:35 +0200."
Date: Thu, 13 Apr 2000 00:45:59 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Even more observations:

=> Corruption happens in "chunks" that look like network packets:

	-> cmp -l 0 2
      1 6572503  57 315
      2 6572505 310  22
      3 6572507 315 165
      4 6572509  22 141
	...
    699 6573909 240 135
    700 6573911 324 104
    701 6573913 135 226
    702 6573915 104 141	<= 1412 Bytes bad, followed by good data, until:
    703 11721589 240 226
    704 11721591  16 251
    705 11721593 226 261
    706 11721595 251 115
	...
   1404 11722997 173  43
   1405 11722999 301  61
   1406 11723001  43 201
   1407 11723003  61  55 <= 1414 Bytes bad, followed by good data, until:
   1408 39669229 166 277
   1409 39669231  70 330
   1410 39669233 277  33
   1411 39669235 330  23
	...
   2195 40193571 254 373
   2196 40193573 155 242
   2197 40193575 373   2
   2198 40193577 242 321
   2199 40193579   2  22 <=
   2200 43640893   0 267
   2201 43640969 221 156
   2202 43640971 141  70
   2203 43640973 156 202
	...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The most difficult thing in the world is to know how to  do  a  thing
and to watch someone else doing it wrong, without commenting.
                                                        -- T.H. White

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
