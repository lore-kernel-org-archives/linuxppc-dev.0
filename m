Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id F3107DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:11:05 +1100 (EST)
Date: Mon, 2 Feb 2009 11:11:01 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grzegorz Bernacki" <gjb@semihalf.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
Message-ID: <20090202111101.5f95bd8b@lappy.seanm.ca>
In-Reply-To: <4986EC33.9000600@semihalf.com>
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 02 Feb 2009 13:50:59 +0100
"Grzegorz Bernacki" <gjb@semihalf.com> wrote:


> I would like to have support for following devices in defconfig for
> digsy:
> - LXT PHY
> - RTC DS1337
> - EEPROM AT24
> - MTD partitioning based on OF description

I am seeing a problem where if I enable CONFIG_EEPROM_LEGACY and
CONFIG_EEPROM_AT24, then the at24 driver does not work. Would you mind
trying that?

> BTW,
> I noticed that there are some problems with mounting file system
> over NFS on Linux-2.6.29-rc3, I see following messages:
> ...
> [  339.813807] nfs: server 192.168.1.1 not responding, still trying
> [  339.832144] nfs: server 192.168.1.1 OK
> ...
> 
> I haven't noticed in on Linux-2.6.29-rc2. Is there any known problem?

Does it only happen at mount time? We get this quite often at work,
but it never happens at home. I assumed it was just due to the flaky
networking at work.

Cheers,
   Sean
