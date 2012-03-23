Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CA+55aFx+dXoJ=MGmpyzepDjBDv8LpXqdxUBCbdrakMKBsKpmTw@mail.gmail.com>
References: <20120322144817.796e3a8a@jbarnes-desktop>
 <CAE9FiQV96Uz9fU=v4=eBbAogOeehuBM3eHgSr0QW_C68ceADcQ@mail.gmail.com>
 <CA+55aFx+dXoJ=MGmpyzepDjBDv8LpXqdxUBCbdrakMKBsKpmTw@mail.gmail.com>
Date: Fri, 23 Mar 2012 14:29:33 -0700
Message-ID: <CAE9FiQVs5+BVmn46xeXR_GwOYBkYy73-aSKYHQUv3EoTTiUtYQ@mail.gmail.com>
Subject: Re: [git pull] PCI changes (including maintainer change)
From: Yinghai Lu <yinghai@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2012 at 2:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 23, 2012 at 12:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> There are some merge conflicts. Hope attached patch could help Linus a
>> little bit.
>
> Hmm. My merge does not agree with yours at all in the MIPS
> pcibios_fixup_bus() area.
>
> Your patch re-introduces the device resource fixup that Bjorn removed,
> for example.
>
> I think my merge is correct, but hey, people should double-check.

yes, you are right.

Yinghai
