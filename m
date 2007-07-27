Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <46A9925A.2060508@yahoo.fr>
References: <46A9925A.2060508@yahoo.fr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D4037DB6-8832-4057-A9FF-BAD32592E6C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Decermenter overflow interrupt atfer the init.d launch.
Date: Fri, 27 Jul 2007 01:46:42 -0500
To: Nicolas Mederle <mederle_nicolas@yahoo.fr>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 27, 2007, at 1:36 AM, Nicolas Mederle wrote:

> Hi,
>
>        I want to know how the kernel switch the task. Because my  
> kernel
> start very well, and it launch  the init.d. With the log, i can see  
> that
> the kernel launch the getty task. But after, there is a decrementer
> overflow interrupt  ( vector at adress 900 ). Is it the task  
> switch? Or
> is it an error in the decrementer init.

This should be a task switch.  The decrementer is used to handle the  
periodic interrupt to switch processes.

- k
