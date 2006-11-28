Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by ozlabs.org (Postfix) with ESMTP id 7133367B92
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 00:39:47 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Peter Mendham'" <petermendham@computing.dundee.ac.uk>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE : RE : Using Linux on ML405: Some basic questions
Date: Tue, 28 Nov 2006 14:39:36 +0100
Message-ID: <001701c712f2$a5450ce0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <456C14F0.5020103@computing.dundee.ac.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De=A0: Peter Mendham [mailto:petermendham@computing.dundee.ac.uk]
<----> Envoy=E9=A0: mardi 28 novembre 2006 11:53
<----> =C0=A0: alayrac; linuxppc-embedded@ozlabs.org
<----> Objet=A0: Re: RE : Using Linux on ML405: Some basic questions
<---->=20
<----> Wow.  Thanks Chris, that makes a lot of sense, although I had no
idea
<----> that the SystemAce chip was quite so clever.  I take it that the
<----> bitstream in the .ace file is specially constructed by the tools
to
<----> do
<----> the DRAM download?  What is it that produces the text:
<----> loaded at:     00400000 004E21E4
<----> board data at: 004DF13C 004DF154
<----> relocated to:  00405660 00405678
<----> zimage at:     00405C25 004DE92F
<----> avail ram:     004E3000 04000000
<----> I have always assumed that it is a piece of software that does
this.
<----> Is
<----> that correct?

It must be xmd that display messages in its console. All displayed
address correspond to sections (see the linker file) for exemple txt if
for the code , bss is for data...
There is no code running on the powerpc during elf dowload.
<---->=20
<----> Thanks very much for replying, the information is really helpful.
<----> -- Peter

kinds regards

Chris
