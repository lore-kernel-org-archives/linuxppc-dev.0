Message-ID: <3FDEC771.7030907@imc-berlin.de>
Date: Tue, 16 Dec 2003 09:50:57 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK and suse 9.0
References: <3FDEC481.2010708@iti.fi>
In-Reply-To: <3FDEC481.2010708@iti.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kate,

 > I have user eldk a lot with Redhat 9 but after they discontinued it, i
 > decided to change to
 > suse 9 but looks a like that least standard eldk 2.1.0 install does not
 > work with suse9


Wolfgang Denk wrote on the U-Boot mailings list:

 > This is a known problem which will be fixed in ELDK-3.0 (due to be out soon).
 >
 > You have two options:
 >
 > 1) Install on an older SuSE or on a RedHat system and copy the files
 > 2) download the file ftp://ftp.denx.de/pub/tmp/ELDK-update-2.2.0.tar.bz2
 >    Then change into the source tree with the ELDK files and perform
 >    the following operations:
 >
 >         bash$ rm RPMS/rpm-4.0.3-1.03b_2.i386.rpm \
 >                 RPMS/rpm-build-4.0.3-1.03b_2.i386.rpm \
 >                 RPMS/rpm-devel-4.0.3-1.03b_2.i386.rpm \
 >                 tools/usr/lib/rpm/rpmpopt-4.0.3
 >         bash$ tar jxf /tmp/ELDK-update-2.2.0.tar.bz2
 >
 >    Then build the ISO image as documented, and try again.
 >
 >
 > Best regards,
 >
 > Wolfgang Denk

Both ways work. I am using ELDK-2.2 on SuSE 9.

Good luck,

Steven

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
fon: +49 30 467090-0                    Tel: 030 / 467090-0
fax: +49 30 4631576                     fax: 030 / 4631576


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
