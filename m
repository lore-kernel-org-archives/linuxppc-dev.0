From: "challaharikumar" <challaharikumar@tataelxsi.co.in>
To: "'Kumar Gala'" <kumar.gala@motorola.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <dan@embeddededge.com>
Subject: RE: MPC8272 Fast Ethernet Controller drver
Date: Fri, 27 Feb 2004 12:34:51 +0530
Message-ID: <000d01c3fcff$ff4fdd70$3401080a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <8206821A-686F-11D8-9EC9-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!
Mr.Kumar and Mr Dan

Thanks for ur help. i've downloaded the bitkeeper linuxppc-2.4 kernel tree.
After this
i've got all the sources in s.xx.c I am getting 's' as prefix for all of the
source files in all
the directories. Is this a patch file kind of thing??? How do i get the
original sources from
these files. How to make the kernel for ADS8272 board. Any help would be
great. Any documentation available... Thanks in advance ...

regards
Harikumar



-----Original Message-----
From: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Kumar Gala
Sent: Thursday, February 26, 2004 8:52 PM
To: Dan Malek
Cc: linuxppc-dev@lists.linuxppc.org; challaharikumar
Subject: Re: MPC8272 Fast Ethernet Controller drver



The changes to support the ADS8272 are in the current linuxppc-2.4
bitkeeper tree.

- kumar

On Feb 26, 2004, at 9:10 AM, Dan Malek wrote:

>
> challaharikumar wrote:
>
>> I want to know about the MPC8272 Fast Ethernet Controller. Is it same
>> as
>> MPC8260???
>> In what way MPC8272 FCC differs from MPC8260.
>
> The FCC is the same, the CPM is slightly different.
>
>> Is there any Ethernet driver available for MPC8272 Fast Ethernet
>> Controller??
>
> There are some minor patches on the way into the source code, along
> with updates to documentation errors in the manuals.  We caught all
> of this while merging the existing 82xx CPM2 with the 85xx CPM2 into
> common code.  Take a look at the ADS8272 configuration.
>
> I don't know where the patches are in the pipeline.  I think the
> linuxppc-2.4 in BitKeeper is current.
>
>
> 	-- Dan
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
