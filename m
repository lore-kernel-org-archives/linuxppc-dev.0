Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2727A67A41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 23:13:15 +1000 (EST)
Date: Tue, 18 Apr 2006 17:13:17 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: New fs_enet driver : filling platform_data
Message-ID: <20060418171317.5f9db046@vitb.ru.mvista.com>
In-Reply-To: <200604181509.38713.laurent.pinchart@tbox.biz>
References: <200604181509.38713.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 18 Apr 2006 15:09:38 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi everybody,
> 
> I'm trying to use the new fs_enet FCC ethernet driver (drivers/net/fs_enet) 
> with an Embedded Planet EP8284 board (LXT971A phy).
> 
> I don't know how/where to fill the platform_data structure that the 
> mii-bitbang driver uses. Could anyone give me some help, or point me to a 
> sample implementation for a similar platform ?
> 
I have posted recently fs_enet driver update to the list - (FS_ENET: use PAL for mii management)
- you'll find needed platform info updates for 8272ads and 866 ads in the patch. I am going to push it rather shortly, after I'll correct some minor issues appeared.

> Best regards,
> 
> Laurent Pinchart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
