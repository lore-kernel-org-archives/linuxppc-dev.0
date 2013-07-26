Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E03D2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 21:56:27 +1000 (EST)
Message-ID: <51F263AC.4080009@asianux.com>
Date: Fri, 26 Jul 2013 19:55:24 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
References: <51ECD91D.7090903@asianux.com> <20130723135809.GG31944@concordia>
 <51EF21FD.9020509@asianux.com> <51F1F6E3.7040502@asianux.com>
 <51F26164.1070801@asianux.com>
In-Reply-To: <51F26164.1070801@asianux.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, "paulus@samba.org" <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jovi.zhangwei@huawei.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2013 07:45 PM, Chen Gang wrote:
> c000000000080d30:	00 00 04 ac 	.long 0x4ac
> c000000000080d34:	60 00 00 00 	nop
> c000000000080d38:	60 00 00 00 	nop
> c000000000080d3c:	60 00 00 00 	nop
>  816                 case 'm':
>  817                         cmd = inchar();
>  818                         switch (cmd) {
>  819                         case 'm':
>  820                         case 's':
>  821                         case 'd':
>  822                                 memops(cmd);
>  823                                 break;
>  824                         case 'l':
>  825                                 memlocate();
>  826                                 break;
>  827                         case 'z':
>  828                                 memzcan();
>  829                                 break;
>  830                         case 'i':
>  831                                 show_mem(0);
>  832                                 break;
>  833                         default:
>  834                                 termch = cmd;
>  835                                 memex();
>  836                         }
>  837                         break;
> c000000000080d40:	4b ff df b1 	bl      c00000000007ecf0 <.inchar>

Oh, sorry again, the comments above is incorrect, please skip them (816
-- 837)

If want to see the related code directly, please search '680(r1)' (which
mean 'fromipi')

Thanks.
-- 
Chen Gang
