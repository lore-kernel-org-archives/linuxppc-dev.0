Message-ID: <09EDD8D5C7874D439B2155E0359890C7E88E45@mail.redmond.radioframenetworks.com>
From: John Feller <JFeller@RADIOFRAMENETWORKS.COM>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: DMA transfer into sk_buff - cached memory question
Date: Tue, 9 Mar 2004 13:02:54 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Please, read Documentation/DMA-mapping.txt.

Ah - I'm an idiot.  I had read about "pci_map_single", but it didn't occur
to me that it could be used after memory was kmalloc'd elsewhere.  Looked at
some existing networking code (tulip driver) to see how it is done.  The
"pci" in the name confused me, I guess :o}

Thank you for the help, and sorry for the stupid question.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
