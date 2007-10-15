Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18195.64446.825842.427068@cargo.ozlabs.ibm.com>
Date: Tue, 16 Oct 2007 09:46:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
In-Reply-To: <4713ABDA.2000506@ru.mvista.com>
References: <1190345162.620000.305760830507.qpush@thor>
	<Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	<46FAB56E.8080509@ru.mvista.com>
	<Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
	<1190836713.23376.41.camel@chaos> <4713ABDA.2000506@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>    Eh... poor you. Tony got clockevent driver reengineered for no apparent 
> reason.  And he's introduced the jiffy drift by deleting the main loop from 
> timer_interrupt().

The main loop in timer_interrupt() became unnecessary, because
update_wall_time contains an equivalent loop.

Paul.
