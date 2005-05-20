Return-Path: <stefan.nickl@kontron.com>
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050519231446.29487C1512@atlas.denx.de>
References: <20050519231446.29487C1512@atlas.denx.de>
Content-Type: text/plain
Date: Fri, 20 May 2005 08:44:37 +0200
Message-Id: <1116571478.12823.20.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without
	Open Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-05-20 at 01:14 +0200, Wolfgang Denk wrote:
> > ppc64 kernel anyways ? I don't think that is very relevant. On the
> 
> I am aware that you think so, and I try to raise  your  awareness  of
> the fact that there is a huge number of small machines out there.
> 
> Please keep in mind that the same interface will be forced sooner  or
> later  on small 8xx systems with maybe just 4 MB flash and 8 or 16 MB
> RAM.

I don't seem to be getting the point: As you proved conclusively on your
website, 2.6 (and IMHO very likely anything that will come after it)
does not scale down well to small systems like the 8xx any more anyways.

And I don't think such a major change will be "forced" upon the mostly
frozen 2.4 tree.

So why try to stop the folks that want to unite the current "mess" in a
proven superset datastructure that seems to suit quite fine with all
chips that came into production for (at least) the last five years?

-- 
Stefan Nickl
Kontron Modular Computers
