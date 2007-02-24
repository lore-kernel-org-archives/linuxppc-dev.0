Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 4C090DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 02:46:17 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so481491ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 07:46:15 -0800 (PST)
Message-ID: <528646bc0702240746ve5d9cd7j150f6d58da1fb964@mail.gmail.com>
Date: Sat, 24 Feb 2007 08:46:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: Compiling Linux Kernel for ML403
In-Reply-To: <BAY115-W5610B35B5ED6C430EA31BB28D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W5610B35B5ED6C430EA31BB28D0@phx.gbl>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/24/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
>
> well
>
> Then, if what you say is correct, We should do almost all of the job by hand, ... this is very difficult and time cosuming....
>
> What is the role of xmake tcl script in generated linux bsp?
>

The EDK <--> Linux kernel interactions is.... messy... at best.  I'm
not at all a fan of the BSP generation approach that EDK uses.  I
understand from the Xilinx folks that they are working to get their
driver code into mainline, but in the meantime you need to do stuff
manually unless you're using the exact kernel source version that the
EDK code generation works with.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
