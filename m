Return-Path: <bgat@billgatliff.com>
Received: from mail-bw0-f212.google.com (mail-bw0-f212.google.com
	[209.85.218.212]) by ozlabs.org (Postfix) with ESMTP id EFA47B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 07:13:20 +1100 (EST)
Received: by bwz4 with SMTP id 4so237688bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 13:13:17 -0700 (PDT)
Message-ID: <4AE7545F.80805@billgatliff.com>
Date: Tue, 27 Oct 2009 15:13:19 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
Content-Type: text/plain; charset=us-ascii
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan Haws wrote:
>
> How can I get that pointer?  Unfortunately I cannot simply use the address of the flash.  Is there some magical function call that gives me access to that portion of the memory space?
>   

$ man 2 mmap

You want MAP_SHARED and O_SYNC.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
