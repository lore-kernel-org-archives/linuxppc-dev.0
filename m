Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40705290701h590998bfjc36385fa08a821d0@mail.gmail.com>
Date: Tue, 29 May 2007 08:01:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "angelalinyao@163.com" <angelalinyao@163.com>
Subject: Re: How can I get a ramdisk.image for linux2.6 running on ML403?
In-Reply-To: <2547937.196031180424819306.JavaMail.nabble@isper.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <2547937.196031180424819306.JavaMail.nabble@isper.nabble.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/29/07, angelalinyao@163.com <angelalinyao@163.com> wrote:
>     Is there any ramdisk.image provided for linux 2.6?Or maybe I have to make a ramdisk by myself?If I make a ramdisk by myself,where can I get all the files under dev/?Will the dev/ simply copied from a server or PC which runs linux 2.6 work for ppc405?
>     Any help from you is appreciated.Thank you!

If you just want an out-of-the-box ramdisk, you can use the one in ELDK

http://www.denx.de/wiki/DULG/ELDK

Or, you can mount your existing ramdisk image on another Linux box and
copy the needed files over.  The /dev entries are the same across all
architectures.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
