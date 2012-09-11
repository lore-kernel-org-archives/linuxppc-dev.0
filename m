Return-Path: <anton@samba.org>
Date: Tue, 11 Sep 2012 11:23:17 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC patch powerpc,trace] Avoid suspicious RCU usage reporting
 for some tracepoints
Message-ID: <20120911112317.0ec8f154@kryten>
In-Reply-To: <1347253812.2385.148.camel@pasglop>
References: <1347253133.2725.45.camel@ThinkPad-T420>
 <1347253812.2385.148.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> > Or could we just move these tracepoints inside the
> > irq_enter()/irq_exit() area? (Seems not good for the timer_interrupt
> > case). 
> 
> I'd say just move them in. Anton, any objection ?

Sounds reasonable, no objections from me.

Anton
