Subject: Re: MPC8272 Fast Ethernet Controller drver
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: dan@embeddededge.com
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1078145848.12061.11.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 13:57:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan,

I did a 'bk clone bk://ppc.bkbits.net/linuxppc-2.4' but
can't find a reference to fcc microcode. Is it not in yet?

thanks,

Jaap-Jan

On Feb 26, 2004, at 9:10 AM, Dan Malek wrote:
>
> challaharikumar wrote:
>
>> I want to know about the MPC8272 Fast Ethernet Controller. Is it same
>> as MPC8260??? In what way MPC8272 FCC differs from MPC8260.
>
> The FCC is the same, the CPM is slightly different.
>
>> Is there any Ethernet driver available for MPC8272 Fast Ethernet
>> Controller??
>
> There are some minor patches on the way into the source code, along
> with updates to documentation errors in the manuals. We caught all
> of this while merging the existing 82xx CPM2 with the 85xx CPM2 into
> common code. Take a look at the ADS8272 configuration.
>
> I don't know where the patches are in the pipeline. I think the
> linuxppc-2.4 in BitKeeper is current.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
