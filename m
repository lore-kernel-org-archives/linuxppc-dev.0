Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 79579DDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:52:47 +1100 (EST)
Date: Mon, 2 Feb 2009 11:52:43 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grzegorz Bernacki" <gjb@semihalf.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
Message-ID: <20090202115243.0a13ebb1@lappy.seanm.ca>
In-Reply-To: <498722F4.3070800@semihalf.com>
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com>
	<20090202111101.5f95bd8b@lappy.seanm.ca>
	<498722F4.3070800@semihalf.com>
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

On Mon, 02 Feb 2009 17:44:36 +0100
"Grzegorz Bernacki" <gjb@semihalf.com> wrote:

> I enabled CONFIG_EEPROM_LEGACY in my defconfig and I can see eeprom 
> detected in dmesg and I can also read/write to it via file 
> /sys/bus/i2c/devices/0-0050/eeprom.

Thanks for trying that! Now I need to see what I am doing different.

Cheers,
   Sean
