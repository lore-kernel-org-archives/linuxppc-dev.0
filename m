Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 7779F2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 08:03:54 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Oct 2004 16:49:17 EDT."
	<85927CE7-196B-11D9-9299-003065F9B7DC@embeddededge.com>
Date: Sat, 09 Oct 2004 00:03:28 +0200
Sender: wd@denx.de
Message-Id: <20041008220333.B4276C1430@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <85927CE7-196B-11D9-9299-003065F9B7DC@embeddededge.com> Dan Malek wrote:
> 
> I want all of the CPM and 8xx/82xx/85xx configuration to be in
> a common menu, just like it is today.  I don't understand the
...
> implement it that way against our wishes.  Based upon the
> processor type, we should be invoking different Kconfig
> scripts that although may use the same sources have different
> configuration option criteria.  It is significantly easier for
> us to keep those things local for consistent modification,
> and I contend will make it easier to focus on the configuration
> selections when doing so interactively.

Just for the record: I'm 100% in accord with Dan.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Though a program be but three lines long,
someday it will have to be maintained."
- The Tao of Programming
