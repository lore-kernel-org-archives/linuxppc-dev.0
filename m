Date: Thu, 04 Oct 2001 18:27:20 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: Improving ramdisk uncompression time...
To: Subodh Nijsure <SNijsure@SkyStream.com>
Cc: "'linuxppc-embedded '" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3BBC8DE8.3AE9B8FC@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <B25E2E5A003CD311B61E00902778AF2A02637AD2@SERVER1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>
> Hello,
>
> My setup has rather large ramdisk 5MB as the ramdisk contains
> firmware for other boards in the system. In total boot time of
> about 60 seconds, close to 50% is spent in uncompressing the ramdisk.

I have a 10MB ramdisk when compresses is a little over 2MB. On a 405 in
200MHz this takes 1 second to uncompress.

Are you sure you have cache working.

You could try to use cramfs. Then the the data don't have to be uncompressed.
I think I have not used it myself.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
