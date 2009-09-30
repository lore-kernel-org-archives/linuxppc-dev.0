Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: 64bit kernel is huge 
In-reply-to: <20090928074503.GB16073@kryten> 
References: <20090928074503.GB16073@kryten>
Date: Wed, 30 Sep 2009 16:01:27 +1000
Message-ID: <5642.1254290487@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> # size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 9812942	1982496	1105228	12900666	 c4d93a	vmlinux

... over kernel releases with pseries_defconfig:

           text		data	    bss	    dec		hex	
2.6.32-rc1 9872090      1971184 1105236 12948510        c5941e
2.6.31     9730495	1708796	1054236	12493527	bea2d7
2.6.30     9221595	1620728	1052812	11895135	b5815f
2.6.29     9104807	1569840	 785292	11459939	aedd63
2.6.28     8647080	1699460	 780472	11127012	a9c8e4
2.6.27     7461663	1505796	 774400	9741859		94a623
2.6.26     7192966	1470432	 631024	9294422		8dd256
2.6.25     7163913	1558800	 568048	9290761		8dc409

We are getting bigger pretty quickly :-(

Mikey
