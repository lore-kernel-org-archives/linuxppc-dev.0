Return-Path: <dhlii@dlasys.net>
Message-ID: <465561A4.9020403@dlasys.net>
Date: Thu, 24 May 2007 05:57:56 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com>
In-Reply-To: <46555294.6040104@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Hello,
>
> My Xilinx Virtex Development tree is now alive again.
>
> Please use the dev branch (master is just the ko copy):
> http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=shortlog;h=dev
> Currently it has a patch to enable the framebuffer
> on ML403 and ML300 plus TEMAC driver that uses
> the PHY lib (FIFO mode support only).
> The TEMAC driver is work in progress.
> In the queue are SGDMA TEMAC support, and SPI driver
> (master only).
>
> My concern is that the TEMAC driver uses the "level 1 drivers" from EDK 9.1.
> The comments / opinions on how to get this driver (not the current incomplete
> version of course) accepted into the ko tree are very welcomed.
>   
I have an almost working FIFO TEMAC driver. It is similarly based.
it started out based on the Trek webserver sample
I spent probably 3-4 days de-EDKing it into something that fit into a
single source and was closer to ko norms.
It is based on approximately the EDK 8.1 stuff. You are welcome to it,
if it could be helpful in anyway.
I am all for getting an acceptable driver into the ko tree.




> I am not quite satisfied with how the current git repository
> is structured, and may rework it completely later.
>
> Thanks,
> Andrei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
