In-Reply-To: <403E0C74.6040508@embeddededge.com>
References: <003201c3fc70$30a0ff20$3401080a@telxsi.com> <403E0C74.6040508@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8206821A-686F-11D8-9EC9-000393DBC2E8@motorola.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	challaharikumar <challaharikumar@tataelxsi.co.in>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: MPC8272 Fast Ethernet Controller drver
Date: Thu, 26 Feb 2004 09:21:53 -0600
To: Dan Malek <dan@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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
