Message-ID: <75DF04AC5ED4D511A9810090273CB4163A67B6@ROKONET-E>
From: Eli Brin <elib@rokonet.co.il>
To: "'brian.auld@adic.com'" <brian.auld@adic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems installing DENX ELDK
Date: Sun, 26 Jan 2003 15:30:46 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Brian,

We have installed the ELDK 2.0.2 (ppc_8xx) on Redhat Linux 8.0 without any
problems.  I suggest to create and installation CD (ISO image), and begin
the installation from there.

Every thing is covered in the documentation.

Best Regards,
Eli Brin



-----Original Message-----
From: brian.auld@adic.com [mailto:brian.auld@adic.com]
Sent: Friday, January 24, 2003 6:12 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems installing DENX ELDK



I am trying to setup my tool-chain for embedded PPC development. I am
considering different approaches, one of them using DENX's ELDK.

Regarding the DENX option, I'm not getting very far as after having run the
"get -R eldk-ppc-linux-x86" command as per the installation instructions, I
find that underlying files in the, for example, "tools" directory do not
exist. I therefore cannot proceed with the installation.

Have others had problems downloading and installing (vers 2.0.2) of this
kit? I also found that the directory structure within 'eldk-linux-ppc-x86'
directory is not consistent with what's in the document.

Thanks

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
