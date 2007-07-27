Return-Path: <benh@kernel.crashing.org>
Subject: Re: Decermenter overflow interrupt atfer the init.d launch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D4037DB6-8832-4057-A9FF-BAD32592E6C9@kernel.crashing.org>
References: <46A9925A.2060508@yahoo.fr>
	<D4037DB6-8832-4057-A9FF-BAD32592E6C9@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 17:26:20 +1000
Message-Id: <1185521180.5495.194.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-27 at 01:46 -0500, Kumar Gala wrote:
> On Jul 27, 2007, at 1:36 AM, Nicolas Mederle wrote:
> 
> > Hi,
> >
> >        I want to know how the kernel switch the task. Because my  
> > kernel
> > start very well, and it launch  the init.d. With the log, i can see  
> > that
> > the kernel launch the getty task. But after, there is a decrementer
> > overflow interrupt  ( vector at adress 900 ). Is it the task  
> > switch? Or
> > is it an error in the decrementer init.
> 
> This should be a task switch.  The decrementer is used to handle the  
> periodic interrupt to switch processes.

I would have expected quite of few of these actually before you get
there :-)

Ben.
