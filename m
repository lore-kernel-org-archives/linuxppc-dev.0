To: schmitz@opal.biophys.uni-duesseldorf.de
Cc: ajoshi@shell.unixbox.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New XFree86-pmac rsync tree
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
In-Reply-To: <Pine.LNX.4.10.10007171100220.22569-100000@opal.biophys.uni-duesseldorf.de>
References: <20000715113541Y.kohkichi@venus.dti.ne.jp>
	<Pine.LNX.4.10.10007171100220.22569-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000720221208U.kohkichi@venus.dti.ne.jp>
Date: Thu, 20 Jul 2000 22:12:08 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Mon, 17 Jul 2000 11:01:01 +0200 (CEST), Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> said:

>> Acceleration of ati is great.  The problem, however, is
>> that it can not be used.  When I used ati module, the
>> color on X was shifted to brown (or red?), and a lot of
>> spectrum were seen.

Schmitz> Use 8 or 15 bpp, nothing else worked for me.

Schmitz> 	Michael

Thank you for quick advice, and sorry for delayed response.
I'm away for a while.

Actually, my correspondign part of XF86Config is as the following;

    Driver      "ati"
#     Driver      "fbdev"
        BusID       "PCI:0:18:0"
EndSection

Section "Screen"
        Identifier "Screen0"
#       Device     "r128"
#       Monitor    "Monitor0"
    Device     "ATY,RagePro_C"
    Monitor    "iMac Monitor"
        DefaultDepth      15

I also tried DefaultDepth 8, and both settings also gave me
a lot of spectrum and strange color on X.

Thanks a lot anyway.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
