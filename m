Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
In-reply-to: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
Date: Fri, 07 Dec 2012 16:41:36 +1100
Message-ID: <22146.1354858896@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> commit f6e3c1f706cb6922349d639a74ff6c50acc8b9f8
> Author: Jimi Xenidis <jimix@pobox.com>
> Date:   Wed Dec 5 13:41:25 2012 -0500
> 
>     powerpc: Remove unecessary VSX symbols
>     
>     The symbol THREAD_VSR0 is defined to be the same as THREAD_FPR0.  Its
>     presence causes build issues with more complex configurations.
>     
>     Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> 

Can you explain what these "complex configurations" are?

Mikey
