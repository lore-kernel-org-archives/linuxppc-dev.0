Return-Path: <vantranbk@yahoo.com.au>
Received: from web33012.mail.mud.yahoo.com (web33012.mail.mud.yahoo.com
	[209.191.69.127]) by ozlabs.org (Postfix) with SMTP id 4A00E67B59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 11:25:03 +1000 (EST)
Message-ID: <20061019012501.38511.qmail@web33012.mail.mud.yahoo.com>
Date: Thu, 19 Oct 2006 11:25:01 +1000 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Not know how to build image and user application from ELDK 3.1.1
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-131652325-1161221101=:38409"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-131652325-1161221101=:38409
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hanks Wolfgang Denk
I'm reinstall ELDK 3.1.1 and it ok
I rebuild openssl like that 
- Download openssl-0.9.7f-7.10_1.src.rpm in <project>/usr/src/denx/SRPMS
- Go to <project>/usr/src/denx/SRPMS and run 
        ppc_8xx-rpm -iv openssl-0.9.7f-7.10_1.src.rpm
- Go to <project>/usr/src/denx/SPECS and run
        ppc_8xx-rpmbuild  openssl.spec
Then  I receive  in   <project>/usr/src/denx/openssl-0.9.7f/   libssl.so.0.9.7 and  openssl in <project>/usr/src/denx/openssl-0.9.7f/apps

That's OK
But I don't know Was command openssl added in image in <project>/ppc_8xx/images? If no how i can do it ?
I also want to rebuild kernel but i only receive vmlinux in <project>/ppc_8xx/usr/src/linux/ Was vmlinux  added in image in <project>/ppc_8xx/images? If no how i can do it ?
If I want to build an application but not in ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/
 how can I do?

Thanks
Wolfgang Denk <wd@denx.de> wrote: In message <20061016142137.34580.qmail@web33007.mail.mud.yahoo.com> you wrote:
>
> I have just installed ELDK 4.0 for TQM 8xxL and read it README but I don't know how to build my custom image or adding user application.Such as I want to build ssh and openssh but I don't know where to start and how to do it step by step.
> Every one who HAD did it please  guide me step by step to do it

I strongly recommend to read the extensive documentation that is
available at  http://www.denx.de/wiki/view/DULG/Manual?stickboard=tqm8xxl

Also, I would like to point out that you should use  ELDK  3.1.1  for
MPC8xx  based  systems  like  the  TQM8xxL (that's the reason why the
TQM8xxL ships with ELDK 3.1.1 included on CDROM).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A Perl script is correct if it's halfway readable and  gets  the  job
done before your boss fires you.
                       - L. Wall & R. L. Schwartz, _Programming Perl_
 		
---------------------------------
On Yahoo!7
 Photos: Unlimited free storage – keep all your photos in one place!
--0-131652325-1161221101=:38409
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hanks <b><i>Wolfgang Denk<br>I'm reinstall ELDK 3.1.1 and it ok<br>I rebuild openssl like that <br>- Download openssl-0.9.7f-7.10_1.src.rpm in &lt;project&gt;/usr/src/denx/SRPMS<br>- Go to </i></b><b><i>&lt;project&gt;/usr/src/denx/SRPMS and run <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ppc_8xx-rpm -iv </i></b><b><i>openssl-0.9.7f-7.10_1.src.rpm</i></b><br>- Go to <b><i>&lt;project&gt;/usr/src/denx/SPECS and run<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  ppc_8xx-rpmbuild&nbsp; openssl.spec<br>Then&nbsp; I receive&nbsp; in&nbsp;  </i></b><b><i>&lt;project&gt;/usr/src/denx/openssl-0.9.7f/&nbsp;&nbsp; libssl.so.0.9.7 and&nbsp; openssl in </i></b><b><i>&lt;project&gt;/usr/src/denx/openssl-0.9.7f/apps<br><br>That's OK<br>But I don't know Was command openssl added in image in </i></b><b><i>&lt;project&gt;/ppc_8xx/images? If no how i can do it ?<br>I also want to rebuild kernel but i only receive vmlinux in </i></b><b><i>&lt;project&gt;/ppc_8xx/usr/src/linux/ </i></b><b><i>Was vmlinux 
 added in image in </i></b><b><i>&lt;project&gt;/ppc_8xx/images? If no how i can do it ?<br>If I want to build an application but not in ftp://ftp.sunet.se/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/sources/target/SRPMS/<br>&nbsp;how can I do?<br><br>Thanks<br></i></b><b><i>Wolfgang Denk &lt;wd@denx.de&gt;</i></b> wrote: In message &lt;20061016142137.34580.qmail@web33007.mail.mud.yahoo.com&gt; you wrote:<br>&gt;<br>&gt; I have just installed ELDK 4.0 for TQM 8xxL and read it README but I don't know how to build my custom image or adding user application.Such as I want to build ssh and openssh but I don't know where to start and how to do it step by step.<br>&gt; Every one who HAD did it please  guide me step by step to do it<br><br>I strongly recommend to read the extensive documentation that is<br>available at  http://www.denx.de/wiki/view/DULG/Manual?stickboard=tqm8xxl<br><br>Also, I would like to point out that you should use  ELDK  3.1.1  for<br>MPC8xx  based 
 systems  like  the  TQM8xxL (that's the reason why the<br>TQM8xxL ships with ELDK 3.1.1 included on CDROM).<br><br>Best regards,<br><br>Wolfgang Denk<br><br>-- <br>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux<br>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<br>A Perl script is correct if it's halfway readable and  gets  the  job<br>done before your boss fires you.<br>                       - L. Wall &amp; R. L. Schwartz, _Programming Perl_<p>&#32;
		<hr size=1>On Yahoo!7<br> 
<a href= "http://au.rd.yahoo.com/mail/tag/photos/**http%3A%2F%2Fau.photos.yahoo.com%2F">Photos: Unlimited free storage – keep all your photos in one place!</a>
--0-131652325-1161221101=:38409--
