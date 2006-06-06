Return-Path: <Jeff.Fellin@rflelect.com>
Subject: Re: Intercept System call using Kernel  module is 2.6 kernel
To: mmeswani@utep.edu
Message-ID: <OF75C056A0.F5AF360E-ON85257185.005D288B@teal.com>
From: Jeff.Fellin@rflelect.com
Date: Tue, 6 Jun 2006 13:02:55 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	linuxppc-dev-bounces+jeff.fellin=rflelect.com@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

                                                                                                                                     
                      "Meswani, Mitesh" <mmeswani@utep.edu>                                                                          
                      Sent by:                                             To:       <linuxppc-dev@ozlabs.org>                       
                      linuxppc-dev-bounces+jeff.fellin=rflelect.com        cc:                                                       
                      @ozlabs.org                                          Subject:  Intercept System call using Kernel  module is   
                                                                            2.6 kernel                                               
                                                                                                                                     
                      06/06/2006 12:25                                                                                               
                                                                                                                                     
                                                                                                                                     










>Hello


>I am attempting to run some user code with kernel space permission. I am
using the ppc64 kernel version >2.6.16-rc4-3-ppc64 for IBM Power5
processors.
>In this kernel module I am trying to implement a function that can be
called from user space.
>
>I have found through various posts that using unused system calls and
replacing them temporarily can acheive this >objective.
>
>This is what I am doing, but its not working, please bear with the
slightly long code that follows:
>
>1) since the 2.6 kernel does not export sys_call_table, I grep it from the
boot image
First sign what you are doing is not a good idea. There are better methods
of this
1) device driver interface with read/write/ioctl interface
2) procfs files from a module/driver
3) sysfs files from a module/driver

SNIP
>
>The problem is that when I execute my user app I expect to see two things:
 >a) I should see a message in the log "Executing mitesh_func..." and
> b) A return value of 2
>However I get an error value -1 returned.
An indication of thinking of system calls vs other methods is wrong!.

>Any help and ideas are highly appreciated.
Don't add your own or hijack system calls

Thank you in advance,
Mitesh
 _______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
