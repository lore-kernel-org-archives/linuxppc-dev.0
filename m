Return-Path: <mukundjb@esntechnologies.co.in>
Received: from ns2.astrainfonets.net (unknown [202.125.86.130])
	by ozlabs.org (Postfix) with ESMTP id C4F2A2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 23:37:37 +1100 (EST)
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id iABCW0tm002330
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Nov 2004 12:32:02 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 11 Nov 2004 18:10:46 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ECE24@mail.esn.co.in>
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem Executing thread.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hai all,
I have a query regarding the threads in Linux.
I wrote an application using the pthreads where in I was to read & write
asynchronously. The read  &* write functions are as follows :

void * read( void * X)
{
	int a =3D0;
	while(a< 1000)
	{
		printf("IN read thread %d\n",a);
		a++;
	}
	pthread_exit(0);
}

void * read( void * X)
{
	int b =3D0;
	while(b< 1000)
	{
		printf("IN write thread %d\n",b);
		b++;
	}
	pthread_exit(0);
}

The Output I get is just a series of 1000 read thread printf statements
and a series of 1000 write thread printf statements. Its like as
follows:-

IN read thread 0
IN read thread 1
IN read thread 2
IN read thread 3
.......
.......
.......
IN read thread 1000
IN write thread 0
IN write thread 1
IN write thread 2
IN write thread 3
.......
.......
.......
IN write thread 1000

Why is this happening?=20
Why are my threads getting executed one after the other rather than
simultaneously.


Thanks for the help in advance.

Regards,
Mukund jampala
