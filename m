Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>,
	<Steve.Ferri@radisys.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Unhandled interrupt 0, disabled
Date: Fri, 3 May 2002 08:31:48 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEIHDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FDE@mail.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Just put the 'sync' in __sti().
> It seems to fix the problem on both 2.4.10 and 2.4.18,
> which are the versions I have tested.
>
> > I am using the B.3 version of the 8260

I know that this is unrelated but could you confirm whether B.3 and higher
fixes the CP hang problem when using an external PCI controller such as the
PowerSpan.

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
