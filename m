Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25708.mail.ukl.yahoo.com (web25708.mail.ukl.yahoo.com
	[217.12.10.180]) by ozlabs.org (Postfix) with SMTP id D2AB767A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 01:43:56 +1100 (EST)
Message-ID: <20050228144354.41719.qmail@web25708.mail.ukl.yahoo.com>
Date: Mon, 28 Feb 2005 14:43:54 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
To: emre kara <emrekara2002@yahoo.co.uk>
In-Reply-To: <20050228131626.78019.qmail@web25704.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: High processing power and gigabit interface
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'am sorry.
I have found a NAPI driver for 440gx on an old topic.
I'll test it on our gigabit test platform.
Thanks.
Emre
--------------------------------------------------
There is an experimental PPC4xx NAPI EMAC driver,
which has 440GX 
support (GigE, TAH, scatter-gather, jumbo) for
2.4.30-pre1 (2.6 
version will follow shortly).

Patch can be found at http://kernel.ebshome.net/.

Please, note, full 440GX support is newly added
feature and therefore 
don't consider it stable yet. I'm in process of
testing it. So, use 
it at your own risk.
Eugene Surovegin
------------------------------------------
 

Send instant messages to your online friends http://uk.messenger.yahoo.com 
