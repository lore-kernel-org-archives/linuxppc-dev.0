From: cort@fsmlabs.com
Date: Thu, 25 Jul 2002 00:54:26 -0600
To: akuster <akuster@dslextreme.com>
Cc: Matthew Locke <mlocke@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/Patch] 4xx idle loop
Message-ID: <20020725005426.H5740@cort.fsmlabs.com>
References: <3D3E4145.8030500@dslextreme.com> <3D3F04F7.1020005@mvista.com> <3D3F8EC9.7070105@dslextreme.com> <20020724233921.G5740@cort.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020724233921.G5740@cort.fsmlabs.com>; from cort@fsmlabs.com on Wed, Jul 24, 2002 at 11:39:21PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That should read "there's no need for the indirection..."

} There's need for the indirection for this sort of thing.  The only reason
} I created ppc_md was to allow for different machines to run off a single
} binary but not different chip families.
}
} A big #ifdef for the chip-type would work fine since the chip family is
} known at compile time.  The machine type isn't always know which is the
} reason for ppc_md.
}
} } This sounds like a good idea if we could use
} }   if( ppc_md.powersave != NULL)
} }        ppc_md.powersave();
} }
} } If it is determined that calling power_save() which is resides in an
} } arch/processor specific file then we are talking about many files being
} } hit.  and the current power_save seems to common for many other ppc
} } platforms other than 4xx & 8xx
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
