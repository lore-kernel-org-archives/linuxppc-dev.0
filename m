Return-Path: <markc@mail.com>
Message-ID: <003801c4d885$62ffd580$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: =?ks_c_5601-1987?B?seggw6K9xA==?= <telkimcs@empal.com>,
	<Linuxppc-embedded@ozlabs.org>
References: <20041202111332.41ae7a4c000d614500056bfc.1632@empal.com>
Date: Thu, 2 Dec 2004 10:41:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Subject: Re: [micropatch]mpc852t 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have an 852t board with 2.4.19 running.  It uses smc1, scc3 and scc4.
I used a stock configuration so that smc2 comes up as though it were
present and is tts/1.  But I made no modifications to the kernel and
there were no conflicts.

Are you trying to use a microcode patch?  If so, tell us which one(s)
The whole 8xx microcode patch issue went through a big discussion
a couple of months ago.

Mark Chambers
wvcomputronics.com

----- Original Message ----- 
From: ±è Ã¢½Ä
To: Linuxppc-embedded@ozlabs.org
Sent: Wednesday, December 01, 2004 9:13 PM
Subject: [micropatch]mpc852t


I use proting linux2.4.18 in mpc852t.
I found overlay smc1 and scc3 in dpram paramater.
I try to micropatch mpc852t. but it didn't
Let's me know how to use micropatch.

Thank you for reading a mail.

from cs. kim.





_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
