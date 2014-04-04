Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/7] Build ppc64le kernel using ABIv2, supplemental patches
In-reply-to: <1396591750-8203-1-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
Date: Fri, 04 Apr 2014 17:19:31 +1100
Message-ID: <22750.1396592371@ale.ozlabs.ibm.com>
Cc: philippe.bergheaud@fr.ibm.com, amodra@gmail.com, rusty@rustcorp.com.au,
 rostedt@goodmis.org, ulrich.weigand@de.ibm.com, mjw@linux.vnet.ibm.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote:

> These patches apply against my last series and fix all known
> ABIv2 issues.
> 
> To stress the module loader and dynamic ftrace code, I built an
> allmodconfig kernel and inserted every module I could. I found a bunch
> of bugs in the modules themselves, but in the end I managed to
> get quite a few modules to load:
> 
> # cat /proc/modules | wc -l
> 3830

>From http://antonblanchardfacts.com/?270 :

  Anton Blanchard's machine always has at least 3800 modules installed.

Mikey
