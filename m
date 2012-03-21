Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 499BBB7004
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 09:34:38 +1100 (EST)
To: Tony Breeds <tony@bakeyournoodle.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20120321221402.GA18735@thor.bakeyournoodle.com>
References: <4F69C553.6070409@gmail.com>
 <20120321221402.GA18735@thor.bakeyournoodle.com>
Date: Wed, 21 Mar 2012 23:34:24 +0100
Message-Id: <20120321223424.8CBC3202A4D@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Robert Berger <robert.karl.berger@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Tony,

In message <20120321221402.GA18735@thor.bakeyournoodle.com> you wrote:
> 
> > What puzzles me is that also stuff for boards is being compiled which is
> > not really needed like treeboot-currituck.c even when I configure the
> > kernel for a kilauea board.
> 
> Can you either propvide the config file or the name of the config target
> so I look into why it's enabling the currituck platform.

Robert mentioned it in the Subjct:  he was building for the Kilauea
board, i. e. 40x/kilauea_defconfig 


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I must follow the people.  Am I not their leader? - Benjamin Disraeli
