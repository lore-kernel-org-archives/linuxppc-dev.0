Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: 64bit kernel is huge 
In-reply-to: <14112.1254373570@neuling.org> 
References: <20090928074503.GB16073@kryten> <5642.1254290487@neuling.org>
	<14112.1254373570@neuling.org>
Date: Thu, 01 Oct 2009 15:09:57 +1000
Message-ID: <14693.1254373797@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > 2.6.28     8647080	1699460	 780472	11127012	a9c8e4
> > 2.6.27     7461663	1505796	 774400	9741859		94a623
> 
> If you compile 28 with the 27 pseries_config, you lose most of this
> 1.2MB text bloat.
> 
> If we remove just FUNCTION_TRACER and STACK_TRACER from 28 we gain back
> about 600K.

EXT4 also adds about 200K, between the 27 and 28 configs.

Mikey
