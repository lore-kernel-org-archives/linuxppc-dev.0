Return-Path: <bwarren@qstreams.com>
Received: from smtp109.biz.mail.re2.yahoo.com (smtp109.biz.mail.re2.yahoo.com
	[206.190.53.8]) by ozlabs.org (Postfix) with SMTP id EA354DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 03:52:19 +1000 (EST)
Subject: Re: Making fs_enet phy unaware
From: Ben Warren <bwarren@qstreams.com>
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E8EADF8@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E8EADF8@aquib01a>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 13:52:16 -0400
Message-Id: <1181584336.6079.2.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Antonio,

On Mon, 2007-06-11 at 12:30 +0200, DI BACCO ANTONIO - technolabs wrote:
> Hi all,
> 
> how can I avoid that fs_enet driver uses its associated phy? My problem
> is that my FEC is attached to a switch  and three other ports of the
> switch are connected to three physical connectors. I don't want that the
> driver bothers about the PHYs. 

If you search the archives you'll find patches by Vitaly Bordug and Andy
Fleming for so-called 'Fixed PHY'.  I've been using this for quite a
while and it works quite well.

regards,
Ben
