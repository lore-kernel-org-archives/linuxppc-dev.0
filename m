Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id BC6DD679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:13:18 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ABHvEQ027824
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:17:58 +0300 (EEST)
Message-ID: <4280937C.8000709@intracom.gr>
Date: Tue, 10 May 2005 13:57:00 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Markus Klotzbuecher <mk@creamnet.de>
References: <20050509182747.GA27743@mary>
In-Reply-To: <20050509182747.GA27743@mary>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Markus Klotzbuecher wrote:
> mini_fo is a virtual kernel filesystem that can make read-only file
> systems writable. This is done by redirecting modifying operations to
> a writeable location called "storage directory", and leaving the
> original data in the "base directory" untouched. When reading, the
> file system merges the modifed and original data so that only the
> newest versions will appear. This occurs transparently to the user,
> who can access the data like on any other read-write file system.
> 
> mini_fo was originally developed for use in embedded systems, and
> therefore is lightweight in terms of module size (~50K), memory usage
> and storage usage. Nevertheless it has proved usefull for other
> projects such as live cds or for sandboxing and testing.
> 
> For more information and download of the sources visit the project
> page:
> 
> http://www.denx.de/twiki/bin/view/Know/MiniFOHome
> 
> ChangeLog for mini_fo-0-6-0:
>    - support for 2.4 and 2.6 kernels.
>    - mini_fo now implements all file system operations.
>    - many bugfixes and code cleanup.
> 
> 
> Markus Klotzbuecher

Hi Markus.

This sounds interesting.

Could you post the patches in the list so that we can discuss
them properly?

Regards

Pantelis
