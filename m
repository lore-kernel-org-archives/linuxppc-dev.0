Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (smtp.extricom.com [192.114.46.18])
	by ozlabs.org (Postfix) with SMTP id D3222DDF30
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 21:20:36 +1000 (EST)
Message-ID: <48ABFD77.6030701@extricom.com>
Date: Wed, 20 Aug 2008 14:18:15 +0300
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<alpine.DEB.1.10.0808181439480.796@gandalf.stny.rr.com>
	<48AAB7FF.4070502@extricom.com>
	<alpine.DEB.1.10.0808191614380.4957@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0808191614380.4957@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Tue, 19 Aug 2008, Eran Liberty wrote:
>
>   
>> Steven Rostedt wrote:
>>     
>>>   
>>>       
>>>> Testing tracer sched_switch: PASSED
>>>> Testing tracer ftrace: PASSED
>>>> Testing dynamic ftrace: PASSED
>>>>         
>
> Do you have PREEMPT_TRACER enabled, or any other tracer for that matter?
>
> -- Steve
>   
I can see stack trace & context trace, but they are derived from other 
choices (I can not un select them)

cat .config | grep TRACE
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_STACKTRACE=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_HAVE_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_FTRACE=y
# CONFIG_SCHED_TRACER is not set
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
>   
>>>> Oops: Exception in kernel mode, sig: 11 [#1]
>>>> Exsw1600
>>>> Modules linked in:
>>>> NIP: c00bbb20 LR: c00bbb20 CTR: 00000000
>>>>     
>>>>         
>
>
>   
