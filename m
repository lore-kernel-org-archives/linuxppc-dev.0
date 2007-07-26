Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E0F57DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 05:56:23 +1000 (EST)
Message-ID: <46A8FC1F.5070807@ovro.caltech.edu>
Date: Thu, 26 Jul 2007 12:55:11 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Circular queue
References: <46A5B5BA.2080707@dlasys.net>
In-Reply-To: <46A5B5BA.2080707@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
>     Is there a standard linux datastructure and routines to manage
> circular queues ?
> 
>     I have a device that is not fundimentally different from a serial
> character device
>     except it is faster and the fundimental data type is 36 bits large.
> 
>     I have coded my own routines to setup and maintain a simple circular
> queue,
>     but I was hoping that there might be something more standard that
> already exists.
> 
>     Anyone know of anything ?

Hi David,

Have you looked at the linked-list support? You can use it
for a circular queue.

I just copied the following comments from some driver examples
I wrote a while back:

http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf

  simple_page_buffer.c

  *-----------------------------------------------------------------
  * References:
  * [1] "Linux device drivers", 3rd Ed, J. Corbet, A. Rubini,
  *      G. Kroah-Hartman, 2005
  * [2] "Linux kernel development", 2nd Ed., R. Love.
  *-----------------------------------------------------------------
  */

  * For details on linked-lists, see p295 [1] and p345 [2].

I didn't look at the code again, but I'm pretty sure I used the
linked list for a circular buffer.

Cheers
Dave
