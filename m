Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-106.bluehost.com (outbound-mail-106.bluehost.com
	[69.89.22.6]) by ozlabs.org (Postfix) with SMTP id 59C11DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 03:01:41 +1000 (EST)
Message-ID: <4A085862.5070303@dlasys.net>
Date: Mon, 11 May 2009 12:54:58 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: device trees.
References: <4A0457BC.3040408@dlasys.net>	
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>	
	<1242007203.7767.28.camel@concordia>	
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>	
	<4A07C664.6040609@dlasys.net>
	<ed82fe3e0905110758l59ee1c94nffbfa50280851613@mail.gmail.com>
In-Reply-To: <ed82fe3e0905110758l59ee1c94nffbfa50280851613@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Mon, May 11, 2009 at 1:32 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>
> So all you need to do is have your boot loader create a device tree
> from scratch.  If you're using U-Boot, then you can already do this by
> making the appropriate libfdt calls.  Otherwise, you should probably
> add libfdt to your boot loader.
>   
    As I mentioned before, we do nto use u-boot. I am not looking to
start a debate on it either, but it does not meet a number of our needs,
    and would require significant architectural changes to do so. The
difference between it and devicetrees is that u-boot is avaiable to us
if we want, I did port u-boot to our hardware at one point and it did
everything it promised, but u-boot is optional, device trees are not.
    I do not have to re-architect u-boot to fit into 16k of bram, or
load bit files or .....
     If I want to move past 2.6.26 I have to not only use device trees
but actually make them work in a way that will function as we need with
our systems.
    It is likely I will use libdft as a starting point, but I can not
see it as more than a short term solution. libdft is orders of magnitude
large than our entire monitor, and it is a toolkit rather than the whole
solution.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
