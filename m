Date: Thu, 23 Mar 2000 15:48:57 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Pavel Roskin <pavel_roskin@geocities.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling interrupts
Message-ID: <20000323154857.A11515@medea.fsmlabs.com>
References: <20000323144536.J11342@medea.fsmlabs.com> <Pine.LNX.4.21.0003231654120.31863-100000@sunapee.transcept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0003231654120.31863-100000@sunapee.transcept.com>; from Pavel Roskin on Thu, Mar 23, 2000 at 04:58:52PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For something like this rtl may be better suited for the task.

} Well, this code needs to read some data continously. Then the data must
} be processed and written to a file.
}
} If you expect problems, I could create a new syscall and pass a buffer to
} it. Probably this should be Ok. But the buffer can be huge (comparable
} with the RAM size), so I would like to avoid copying data. This means that
} the kernel needs to write to the userspace buffer directly.
}
} Thank you for the reply.
}
} Regards,
} Pavel Roskin
}
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
