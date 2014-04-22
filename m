Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, ulrich.weigand@de.ibm.com, amodra@gmail.com,
 mikey@neuling.org, mjw@linux.vnet.ibm.com, rostedt@goodmis.org,
 philippe.bergheaud@fr.ibm.com
Subject: Re: [PATCH 6/7] powerpc/ftrace: Use module loader helpers to parse
 trampolines
In-Reply-To: <1396591750-8203-7-git-send-email-anton@samba.org>
References: <1396591750-8203-1-git-send-email-anton@samba.org>
 <1396591750-8203-7-git-send-email-anton@samba.org>
Date: Tue, 22 Apr 2014 16:28:14 +0930
Message-ID: <87y4yxhmux.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:
> Now we have is_module_trampoline() and module_trampoline_target()
> we can remove a bunch of intimate kernel module trampoline
> knowledge from ftrace.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Oh god, I had no idea this code existed.

I really wanted to implement the R_PPC64_TOCSAVE optimization, and I was
thinking of frobbing the stub code.  At least now it's all in one place,
because I would have completely missed this.

Thanks,
Rusty.
