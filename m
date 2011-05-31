Return-Path: <dbaryshkov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7373D079-743D-4D49-BDC6-2BEAF14C43DF@kernel.crashing.org>
References: <20110531131737.GA29164@doriath.ww600.siemens.net>
	<7373D079-743D-4D49-BDC6-2BEAF14C43DF@kernel.crashing.org>
Date: Tue, 31 May 2011 23:25:05 +0400
Message-ID: <BANLkTikNxFktd6c4rM9E0Xc+f6mQ=FGu7A@mail.gmail.com>
Subject: Re: PCI EDAC on MPC85xx
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/31/11, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On May 31, 2011, at 8:17 AM, Dmitry Eremin-Solenikov wrote:
>
>> Hello,
>>
>> Long time ago (around July of 2010), I've reported a problem of binding
>> pci error reporting driver to the hardware (See
>> http://thread.gmane.org/gmane.linux.kernel.edac/181). Grant Likely has
>> come with a patch to create platform devices (of_platform at that time),
>> for device_nodes which have "compatible" properties
>> (http://article.gmane.org/gmane.linux.ports.ppc.embedded/36981).
>>
>> The patch was not applied at that time and the problem still arises at
>> 3.0-rc1. Should the patch in question be applied, or is there any new
>> solution?
>> Current version of that patch which I have in my tree is attached
>> to this mail (no original signoff by Grant).
>>
>> --
>> With best wishes
>> Dmitry
>>
>> <0001-of-device-Register-children-with-a-compatible-value-.patch>
>
> I think the desired solution here was to create a new node in the fsl_pci
> code that the edac code would bind against.

Sorry, got mistaken then by Grant=B4s patch. Will provide an update on this=
 topic
soon.


--=20
With best wishes
Dmitry
