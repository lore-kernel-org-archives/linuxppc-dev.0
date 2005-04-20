Return-Path: <pstudencki@yahoo.com>
Received: from web51307.mail.yahoo.com (web51307.mail.yahoo.com
	[206.190.38.173]) by ozlabs.org (Postfix) with SMTP id 2692E67A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 19:55:20 +1000 (EST)
Message-ID: <20050420095519.12652.qmail@web51307.mail.yahoo.com>
Date: Wed, 20 Apr 2005 02:55:19 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: using initramfs with ppc (solution)
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
 
I found a solution of my problem, it was corrupt
initramfs (because of my mistake).
While building kernel 2.6.x an initial, default
initramfs is created with some scripts in directory
./usr
When the kernels starts, it searchs for directory
"/root" on initramfs.
If it does not exist, it returns an error and the
actual mounting process
of the real/user filesystem is aborted.
 
best regards
Pawel
 
 
 
p.s.
    Manoj - unfortunately I don't know any development
board with ppc. I work with our hardware,
    which was developed in another department.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
