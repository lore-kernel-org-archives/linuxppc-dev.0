Return-Path: <aidan@nicta.com.au>
Received: from mail.nicta.com.au (scrubby.nicta.com.au [203.143.174.70])
	by ozlabs.org (Postfix) with ESMTP id 73B89679F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 13:08:48 +1000 (EST)
Message-ID: <444452C7.10709@nicta.com.au>
Date: Tue, 18 Apr 2006 12:45:27 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
References: <20060417210038.18561.qmail@web52008.mail.yahoo.com>
In-Reply-To: <20060417210038.18561.qmail@web52008.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Vincent Winstead wrote:
> Now, as far as step 5, am I supposed to have a symbolic link that is 
> named linux-2.4.x placed into the uClinux-dist directory?  Because 
> there's already a folder named linux-2.4.x which was in there already 
> when I untarred everything.  At the command prompt in the uClinux-dist 
> directory I entered the following line:
>  
> ln -s ../linuxppc-2.4 linux-2.4.x
>  
> and the result of this operation was to put a symbolic link into my 
> linuxppc-2.4 directory with the name of linux-2.4.x  - is this correct?
>  

First, you'll need to move the existing directory aside using
a command like:

    mv linux-2.4.x linux-2.4.x-dist

and then re-run the ln -s command above.

> Now on to Step 6 problem. 
>   How am I supposed to make use uClinux EDK Board Support Package 1.0 
> files?  I'm not sure how to go about using them in the Xilinx Platform 
> Studio in order to generate the necessary auto-config.in file. 
>  

See the document below for the general approach:

>     Even though it is about the microblaze rather than
>     the PPC, a helpful "getting started" document is:
>     http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf
> 

Look particularly at the section "Software Platform Settings"
on page 29, steps 67,68.

If you are not overly familiar with the EDK, it would
be best to find someone locally who can help walk you
through the process of generating a system.

- aidan


--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.
