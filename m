Date: Thu, 28 Oct 1999 21:21:43 -0600
From: Cort Dougan <cort@ppc.kernel.org>
To: Claude Robitaille <crobitaille@videotron.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.3.18 on openprojects.net
Message-ID: <19991028212143.A13879@chimaera.ppc.kernel.org>
References: <Pine.LNX.4.10.9910282101200.3728-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9910282101200.3728-100000@localhost.localdomain>; from Claude Robitaille on Thu, Oct 28, 1999 at 09:22:21PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try the latest Linus release.  It has the latest changes.  VGER and
openprojects.net are woefully behind.


} Yesterday (99-10-27) evening I downloaded 2.3.18 and
} tried to compile it. In order to succeed, I had to turn
} ON CONFIG_MODULE, otherwise I am getting error with
} EXPORT_SYMTAB_not_defined (I think it was in serial.c
} but I am not sure).
} 
} Also, I am trying to had MATH_EMULATION but this fails
} in math.c complaining about a structure not having a
} member name tss (in current->tss). I tryied to follow
} the definitinoa little bit ans found that current is
} a struct task_struct but there is no member that has
} the tss (a least not directly). I found many instances
} (using fgrep) in many asm-PROCESSOR files (for i386,
} MIPS, M68K, etc.) but nothing in asm-ppc. I guess
} the task management fucntions is/are in some sort
} of evolution and math_emu is not up to date. Is
} somebody is working on it?
} 
} 
} Claude
} 

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
