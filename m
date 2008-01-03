Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCFB8DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 05:04:08 +1100 (EST)
Message-ID: <477D2393.5050106@mock.com>
Date: Thu, 03 Jan 2008 10:04:03 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: Drivers' probe function calling order
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The only way I've know to do this is to build the drivers as modules and 
load them in the desired order from the startup scripts called from init.

If there's a better way I would like to know about it also...

jeff


DI BACCO ANTONIO - technolabs wrote:
> How can I fix the calling order of two monolithic drivers? I have an spi
> driver and a driver for a dataflash, how can I force the system to call
> probe function of the spi driver first?
>  
> Bye and thanks.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
