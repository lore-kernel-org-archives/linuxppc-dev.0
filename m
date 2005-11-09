Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9698C686C1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 09:57:22 +1100 (EST)
To: srideep.devireddy@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Nov 2005 09:51:28 +0530."
	<6AD9F6A5F6E096408F0B703773355A075BB03B@CHN-SNR-MBX01.wipro.com>
Date: Wed, 09 Nov 2005 23:57:19 +0100
Sender: wd@denx.de
Message-Id: <20051109225719.B635E3525DE@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FW: U-boot linux kernel 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6AD9F6A5F6E096408F0B703773355A075BB03B@CHN-SNR-MBX01.wipro.com> you wrote:
> 
>   I am right now working on MPC 8272 Ads board  to bring up the u-boot
> and the linux kernel on it . As I am success full in bringing up the
> u-boot . but I am finding it difficult in getting the linux up . As I
> downloaded the vmlinux image from montavista linux site for 8272Ads

Are you sure this image is configured for use with U-Boot?

> board and they  tried to tftp to 100000 at u-boot prompt I am not able

And did you read the FAQ, for example
http://www.denx.de/wiki/view/DULG/LinuxUncompressingError ???

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Alliance: In international politics, the union  of  two  thieves  who
have  their hands so deeply inserted in each other's pocket that they
cannot separately plunder a third.                   - Ambrose Bierce
