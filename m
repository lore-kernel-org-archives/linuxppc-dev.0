Return-Path: <patrick.huesmann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id CDAC967B2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 03:54:40 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so779605wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Apr 2005 10:54:39 -0700 (PDT)
Message-ID: <4256C61A.3030205@gmail.com>
Date: Fri, 08 Apr 2005 19:57:46 +0200
From: Patrick Huesmann <patrick.huesmann@gmail.com>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
References: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cross-compiling under cygwin?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Robert P. J. Day wrote:

>  i've just had a request from a colleague who wants to do all the
>cross-compilation for our 8xx board on a windows box, rather than
>linux.
>
>  there was talk of cygwin, and kdevelop as well.  i'm still parsing
>the rest of the email but is there a canonical URL that discusses
>working in the windows environment?
>  
>
We use colinux (http://www.colinux.org) for that. It's a Linux kernel 
that runs as application under windows. It shares networking with the 
windows system so you can operate it via telnet or ssh. You can even run 
IDEs like kdevelop as remote X application and use the cygwin's X window 
system to use the Linux apps under windows.

Before that, we used VMware, but coLinux is free and IMO, it has better 
performance because it doesn't have to simulate a whole computer (but 
only a small hardware abstraction layer).

It comes with a pre-patched Debian image which gives you a minimal Linux 
installation. From there you set up the networking, and simply apt-get 
install your apps like you would do with a native Linux box.

HTH,
Patrick
