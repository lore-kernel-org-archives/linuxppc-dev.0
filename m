Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews06.kpnxchange.com (cpsmtpb-ews06.kpnxchange.com
 [213.75.39.9]) by ozlabs.org (Postfix) with ESMTP id 282A82C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 23:42:37 +1100 (EST)
Message-ID: <1364388152.1345.29.camel@x61.thuisdomein>
Subject: Re: [PATCH] powerpc: remove PReP
From: Paul Bolle <pebolle@tiscali.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Mar 2013 13:42:32 +0100
In-Reply-To: <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia>
 <1364381223.1345.18.camel@x61.thuisdomein>
 <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 Adam Belay <abelay@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-03-27 at 13:05 +0100, Geert Uytterhoeven wrote:
> This section is CHRP-specific. The cs4232 driver also worked on the
> CHRP LongTrail.
> But I don't remember if the parameter values above also applied to LongTrail.
> I do remember it didn't work without specifing the right parameters, so you
> probably want to keep this section.

My reasoning was quite simply that this file was 14 years old so that
probably nobody is using that stuff anymore. Are people actually using
CHRP (whatever that is)? Anyhow, cs4232 is mentioned in some other files
too:
    $ git grep -l -n cs4232 Documentation/ 
    Documentation/powerpc/sound.txt
    Documentation/sound/alsa/ALSA-Configuration.txt
    Documentation/sound/alsa/alsa-parameters.txt
    Documentation/sound/oss/Introduction
    Documentation/sound/oss/Tropez+

Could these few lines be dumped in one of these (except
powerpc/sound.txt, of course)?


Paul Bolle
