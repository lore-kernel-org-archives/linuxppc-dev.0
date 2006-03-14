Return-Path: <rsmith@imagemap.com>
Received: from fileserver3 (mail.imagemap.com [68.156.94.66])
	by ozlabs.org (Postfix) with ESMTP id 5E3AD679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 03:20:49 +1100 (EST)
Received: from amavis by fileserver3 with scanned-ok (Exim 3.36 #1 (Debian))
	id 1FJC7q-00076Y-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 11:11:58 -0500
Received: from fileserver3 ([127.0.0.1])
	by localhost (fileserver3 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27094-04 for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 11:11:43 -0500 (EST)
Received: from [192.168.0.196] (helo=[192.168.0.196])
	by fileserver3 with esmtp (Exim 3.36 #1 (Debian)) id 1FJC7b-00076S-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 11:11:43 -0500
Message-ID: <4416EACF.2010802@imagemap.com>
Date: Tue, 14 Mar 2006 11:09:51 -0500
From: Randy Smith <rsmith@imagemap.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: rtai for ppc in 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

A bit off topic, but I don't know where else to ask these questions.

I am working to port an existing Lite5200 application that uses rtai on 
the 2.4 kernel to a 2.6 kernel.  I have just noticed that support for 
rtai in 2.6 is limited to the i386 tree.  Is there anyone working on the 
ppc 2.6 rtai?  In looking at the rthal patch for the i386, it seems 
non-trivial.  Otherwise I guess it would be done by now. :-)  
Alternatively, I could rip out the rtai dependent code and just use the 
native 2.6 kernel's improvements for near realtime response and see how 
it goes but that route will take a little time.  I was hoping for a 
quick recompile and go. :-(  Any advice?

Also,  I have been reading about Adeos and rtai's adoption of this.  
Does this implementation preserve the same rtai interface?  It looks 
like it is in the same boat as the rthal for ppc 2.6.  Please correct me 
if I am wrong.

Thanks,

-Randy Smith
Software Engineer
ImageMap, Inc.
