From: "Beena" <beena@gdatech.com>
To: "Dan Kegel" <dank@kegel.com>
Cc: "Silverton Aron-C1710C" <Aron.J.Silverton@motorola.com>,
	"'Ashwin Bihari'" <raz0redge@hotmail.com>, <listmember@orkun.us>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cross-compile package combinations
Date: Tue, 16 Dec 2003 10:21:36 -0800
Message-ID: <FFELLIHDBBOAPGLCBDIPAEBBCDAA.beena@gdatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FD9436F.2060206@kegel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I used crosstool and was able to effortlessly install gcc 3.3.2, glibc 2.3.2
for powerpc. Thanks a lot for your suggestion.

-Beena

-----Original Message-----
From: Dan Kegel [mailto:dank@kegel.com]
Sent: Thursday, December 11, 2003 8:26 PM
To: Beena
Cc: Silverton Aron-C1710C; 'Ashwin Bihari'; listmember@orkun.us;
linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross-compile package combinations


Beena wrote:
> I have observed the same errors when trying to build the bootstrap gcc
> 3.2.3. I understand that
> this is because gcc 3.2.3 build (in case of powerpc) looks for some glibc
> files. So I first built gcc 2.95.3,
> then glibc 2.2.1 and then built bootstrap gcc 3.2.2(you could try with
> 3.2.3) and it compiled fine.

One of the reasons I did crosstool was to avoid that kind of
hackery.  With crosstool, you don't need to build gcc 2.95.3
just to build gcc 3.2.3.  Crosstool does clean builds from pristine,
minimally patched source.
- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
